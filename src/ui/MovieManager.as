package ui
{
	import flash.display.Sprite;
	
	public class MovieManager
	{
		
		public var clip:Sprite = null;
		public var list:Array = null;	
		
		public function MovieManager(cl:Sprite) {
		    clip = cl;
		    list = [];
		}
		
		private function free():void {
			if (list == null) return;
			for (var i:int = 0; i < list.length; i++) {
				list[i].free();
				clip.removeChild(list[i].clip);
			}
			list = null;
			clip = null;
		}
		
		public function remove(state:Movie):Boolean {
			if (clip == null || state.clip == null) return false; 
			var id:int = list.indexOf(state);
			if (id < 0) return false;
			list.splice(id, 1);
			state.free();
			clip.removeChild(state.clip);
			return true;
		}
		
    	public function add(state:Movie):Movie {
        	if (clip == null || state.clip == null) return null;
			list.push(state);
			
			var ind:int = clip.numChildren;
			
			if (ind != 0) {
				if (clip.getChildAt(ind-1) is ChangeClip) ind = clip.numChildren - 1;
				if (ind < 0) ind = 0;
			}
			
			if(state.clip is ChangeClip)
				clip.addChild(state.clip)
			else
				clip.addChildAt(state.clip, ind);
        	return state;
   		}
		
		private function clear():void {
			var tmp:Change = null;
		  	if (clip == null) return;
		    for (var i:int = 0; i < list.length; i++) {
				if (list[i].clip is ChangeClip) {
					tmp = list[i];
				}else{
					list[i].free();
					clip.removeChild(list[i].clip);
				}
		    }
		    list = [];
			if(tmp!=null)list.push(tmp);
		}
		
		public function show(state:Movie, showScr:Boolean):Movie {
			if (showScr) {
				add( new Change(state) );
				return null;
			}
		    clear();
		    return add(state);
		}
		
	}
	
}