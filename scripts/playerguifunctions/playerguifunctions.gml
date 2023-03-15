function PlayerHideDarkMatterBar(){
	with(global.oPlayer)
	{
		dark_matter_bar_target_w = 0;
		hp_in_transition = true;
		hp_transition_down = true;
		hp_transition_progress = 0;
		hp_transition_spd = abs(hp_transition_spd);
	}
}

function PlayerRevealDarkMatterBar(){
	with(global.oPlayer)
	{
		if(dark_matter_and_hp_tutorial_revealed == false)
		{
			BestiaryEnqueue(BESTIARY_PAGE_TYPE.HP_DM_TUTORIAL);
			dark_matter_and_hp_tutorial_revealed = true;
		}
		dark_matter_bar_target_w = dark_matter_max * 4;
		hp_in_transition = true;
		hp_transition_down = false;
		hp_transition_progress = 1;
		hp_transition_spd = -abs(hp_transition_spd);
	}
}