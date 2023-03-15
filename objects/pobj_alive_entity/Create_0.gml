event_inherited();

state = state_free;
previous_state = state_free;

current_hp=max_hp;
entity_is_wet = false;
entity_frozen_timer = 0;

attack_struct = noone;

if(flying) _gravity = 0;