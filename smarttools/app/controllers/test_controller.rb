class TestController < ApplicationController
	def video_test
		test_params = {:nombre => "test vid", :descripcion => "test test", :fechacreacion => Time.now, :urlconvertido => nil,
      :urloriginal => "test_data/ogg_theora.ogv", :contest_id => 1, :estado => 'to_proc', :user_id => 1}
		video = Video.create(test_params);
		video.convert_to_mp4
		redirect_to "/home"
	end
end
