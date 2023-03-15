function emitter_create(){

var _emitter = audio_emitter_create();
//audio_emitter_falloff(_emitter,falloff_ref_dist,falloff_max_dist,falloff_factor);
audio_emitter_position(_emitter,x,y,0);

return _emitter

}