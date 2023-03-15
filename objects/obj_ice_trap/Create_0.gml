activation_range = 10;
//sprite_activated = spr_ice_trap_activate;
hit_effect = spr_ice_trap_hit_effect;
life_time = FRAME_RATE * 14;
life_timer = 0;

activation_gap = FRAME_RATE * 2.5;
activation_gap_timer = activation_gap;
activated = false;
activation_timer = 0;

sprite_idle = spr_ice_trap_surface;
sprite_index = spr_ice_trap_surface_surging;
sprite_surging = sprite_index;
sprite_death = spr_ice_trap_surface_disappearing;

surging = true;

enum ICE_TRAP_SPIKE_TYPE
{
	GROUNDED,
	FLYING,
	BOSS,
	NUMBER
}

DummyWalkingAddTarget();

ice_trap_spikes_sprites = [spr_ice_trap_spike_grounded,spr_ice_trap_spike_flying,spr_ice_trap_spike_boss];

spike_hit_frames = [2,1,2];
spike_effect = noone;

#region Functions

///@arg inst
function IceTrapActivate(_inst){
	activated = true;
	activation_gap_timer = 0;
	
	var _inst_type = 0;
	if(_inst.flying) _inst_type = ICE_TRAP_SPIKE_TYPE.FLYING;
	if(object_is_ancestor(_inst.object_index,pobj_boss))
	{
		_inst_type = ICE_TRAP_SPIKE_TYPE.BOSS;	
	}
	
	var cur_spike_hit_frame = spike_hit_frames[_inst_type];
	var _spike_sprite = ice_trap_spikes_sprites[_inst_type];
	spike_effect = EffectCreate(x,y,_spike_sprite,image_xscale,false);
	activation_timer = AnimationGetFrameLength(_spike_sprite,cur_spike_hit_frame);
}

function IceTrapMelt(){
	instance_destroy();
	EffectCreate(x,y,sprite_death,image_xscale,true);
}

function IceTrapTargetSlowDown(_inst_on_trap){
	EntitySlowDown(_inst_on_trap,1.5,5,spr_freezing);
}
	
#endregion

