///@func Attack(inst, sprite, time, cooldown, speed, target, x_range)
///@arg inst owner of the attack
///@arg sprite
///@arg time* (noone)
///@arg cooldown in seconds
///@arg speed
///@arg target
///@arg x_range
///@arg sound
///@arg type


function Attack(_inst,_sprite,_attack_time,_attack_cooldown,_attack_speed,_attack_target,_attack_x_range,_sound,_type) constructor
{
    attack_owner = _inst;
    attack_sprite = _sprite;
    attack_cooldown_time = _attack_cooldown * FRAME_RATE;
    attack_target = _attack_target;
	attack_sound = _sound;
    if(_attack_time!=noone && _attack_time!=-1)
    {
        AnimationSetLength(_sprite,_attack_time);
    }
    attack_speed = _attack_speed;
    attack_cooldown = attack_cooldown_time / 3;
	attack_x_range = _attack_x_range;
    attack_cooldown_function = function(){
		attack_cooldown += attack_speed;
        return     (attack_cooldown>=attack_cooldown_time)
    }
	range_function = noone;
	charge_function = noone;
	attack_type = _type;
	attack_default_AI = AttackGetDefaultBehaviour(self);
	attack_no_auto_worry = false;
	attack_worry_delay = 0;
	attack_worry_delay_target = player_worry_buffer_time;
	attack_automatic = false;
}