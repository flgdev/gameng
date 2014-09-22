package system
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	public class AudioPlayer
	{
		
		private var _musicOn:Boolean = true;
		public var soundOn:Boolean = true;
		private var soundTrans:SoundTransform;
		private var channel:SoundChannel;
		private var sound:Dictionary;
		
		public function AudioPlayer(myAttr:Object = null) {	
			loadTracks();
			musicOn = Main.gd.musicOn;
			soundOn = Main.gd.soundOn;
			soundTrans = new SoundTransform(0.6);
			channel = new SoundChannel();
			channel.soundTransform = soundTrans;
			playMusic();
		}
		
		public function stopMusic():void 
		{
			if (channel == null) return;
			channel.stop();
			channel = null;
			channel = new SoundChannel();
			channel.soundTransform = soundTrans;
		}
		
		public function playMusic():void 
		{
			if (!musicOn) return;
			if (channel == null) return;
			channel = sound['background'].play(0, int.MAX_VALUE, soundTrans);
		}
		
		public function playSound(name:String):void {
			if (!soundOn) return;
			sound[name].play(0, 1, soundTrans);
		}
		
		private function loadTracks():void 
		{
			sound = new Dictionary();
			sound['background'] = new background();
			sound['bark'] = new bark();
			sound['burp'] = new burp();
			
			//sound[''] = new TrackName();
		}
		
		public function get musicOn():Boolean 
		{
			return _musicOn;
		}
		
		public function set musicOn(value:Boolean):void 
		{
			_musicOn = value;
			if (value) playMusic() else stopMusic();
		}
		
	}
	
}