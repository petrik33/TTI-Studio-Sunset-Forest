event_inherited();
#region//Damaging
if(!target_hit && image_index >= striking_frames_range[0] && image_index <= striking_frames_range[1])
{
	if(!effect_applied)
	{	
		effect_applied = true;
		ScreenFlash(10,c_white);
		EffectCreate(x,y,effect_sprite,image_xscale,false);
		PlayerSoundMake(sn_thunder3);
	}
	with(attack_target)
	{
		if(abs(x - other.x) <= other.hit_range)
		{
			EntityDamage(self,0);
			CameraShake(15,FRAME_RATE * 0.5);
			other.target_hit = true;
		}
	}	
}
#endregion