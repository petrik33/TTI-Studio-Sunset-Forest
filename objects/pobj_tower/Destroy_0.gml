if(audio_is_playing(step_sound)) audio_stop_sound(step_sound);
audio_emitter_free(my_emitter);
StaticLightDestroy(AnimationGetFrameLength(sprite_death));
part_type_destroy(shrine_candle_damaged_flash_part);
