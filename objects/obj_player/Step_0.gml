if(!global.game_is_paused)
{

	//Skills Cooldowning
	for(var i=0;i<SKILLS.NUMBER;i++)
	{
		if(skills[i][SKILL.AVAILABLE])
		{
			if(skills_cooldowns[i]>0)
			{
				skills_cooldowns[@ i]--;
			}
		}
		else
		{
			if(skills_cooldowns[i] < skills[i][SKILL.COOLDOWN])
			{
				skills_cooldowns[@ i]++;
			}
		}
	}

	hp_animation_progress+=0.015;
	
	script_execute(state);

	event_inherited();
}
else
{
	//If Paused
	if(sleeping)
	{
		y = paused_y - abs(sin(pause_waving_progress)) * pause_waving_amplitude;
		pause_waving_progress+=pause_waving_spd;
		if(pause_waving_progress>2*pi) pause_waving_progress -= 2*pi
	}
	
}

spec_stacks_rot_prog += spec_stacks_rot_spd;
if(spec_stacks_rot_prog >= double_pi) spec_stacks_rot_prog -= double_pi;

dark_matter_current = lerp(dark_matter_current,dark_matter_target,0.05);



