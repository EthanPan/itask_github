class CheatcheckController < ApplicationController
	def checkresult
		@res = {}
		@sca = StudentCourseAssignment.find(params[:id])
		attachment_list = @sca.attachments
		path = ''
		attachment_list.each do |att|
			path = att.user_upload.url(:original,false)
		end
		line = getInput(path)
		convert = getHashCode(line)
		fpv1 = getFingerprint(convert)

		@assignment = @sca.assignment
		@user = @sca.user
		sca_list = @assignment.student_course_assignments
		sca_list.each do |s|
			if s.user != @user
				attachment_list = s.attachments
				attachment_list.each do |att|
					path = att.user_upload.url(:original,false)
				end
				line = getInput(path)
				convert = getHashCode(line)
				fpv2 = getFingerprint(convert)
				@res[s.user.name] = check(fpv1,fpv2)
			end
		end
	end

	private
	def getInput(path)
		file = File.open("#{Rails.root}"+"/public"+path)
		line = file.read
		file.close
		line = line.delete " "
		line = line.delete "	"
		line = line.delete "\n"
		return line
	end

	def getHashCode(line)
		$k = 20; $w = 15; i = 0
		convert = []

		while ( i<= line.length()-$k )
			subline = line[i,$k]
			j = 0
			convert[i] = 0
			while ( j < $k )
				convert[i] = convert[i] + subline[j].ord
				j = j + 1
			end
			convert[i] = convert[i] % 293
			i = i + 1
		end
		return convert
	end

	def getFingerprint(convert)
		i = 0; len = -1
		fpv = []
		fpp = []

		while ( i <= convert.size()- $w )
		j = 0; min = 293; pos = -1
		while ( j < $w )
	    	if ( convert[i + j] <= min )
				min = convert[i + j]
				pos = i + j;
			end
			j = j + 1
		end
		if ( len == -1 ) or ( min != fpv[len] ) or ( pos != fpp[len] )
			len = len + 1
			fpv[len] = min
			fpp[len] = pos
		end
		i = i + 1
		end
		return fpv
	end

	def same(char1,char2)
		if ( char1 == char2 )
			return 1
		else
			return 0
		end
	end

	def check(fpv1,fpv2)
		f0 = []
		f1 = []
		i = 0
		while ( i < fpv1.size() )
			j = 0
			while ( j < fpv2.size() )
				max = 0.0
				if ( i % 2 == 0 )
					if ( i > 0 ) and ( f1[j] > max )
						max = f1[j]
					end
					if ( j > 0 ) and ( f0[j-1] > max )
						max = f0[j-1]
					end
					if ( i > 0 ) and ( j > 0 ) and ( f1[j-1]+ same(fpv1[i],fpv2[j]) > max )
						max = f1[j-1] + same(fpv1[i],fpv2[j])
					end
					f0[j] = max
				else
					if ( i > 0 ) and ( f0[j] > max )
						max = f0[j]
					end
					if ( j > 0 ) and ( f1[j-1] > max )
						max = f1[j-1]
					end
					if ( i > 0 ) and ( j > 0 ) and ( f0[j-1]+ same(fpv1[i],fpv2[j]) > max )
						max = f0[j-1] + same(fpv1[i],fpv2[j])
					end
					f1[j] = max
				end
				j = j + 1
			end
			i = i + 1
		end

		if ( fpv1.size() > fpv2.size() )
			tot = fpv1.size()
		else
			tot = fpv2.size()
		end
		if ( fpv1.size() % 2 == 0 )
			res = f1[fpv2.size()-1]/tot
		else
			res = f0[fpv2.size()-1]/tot
		end
		return res * 100
	end
end
