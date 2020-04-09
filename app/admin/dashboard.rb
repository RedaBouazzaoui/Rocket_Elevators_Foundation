ActiveAdmin.register_page "Dashboard" do
  content do
    span do
      button_to "Press for a summary",  welcome_path , method: :get, id: "btnPlay"
    end
    span do
      audio_tag("hello_world.wav", autoplay: true, controls: true)
    end
  end
end
