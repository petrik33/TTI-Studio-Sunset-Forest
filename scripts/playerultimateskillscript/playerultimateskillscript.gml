function PlayerUltimateSkillScript(){
	with(global.boss_manager)
	{
		BossManagerDestroyFragment(boss_current_enum);
	}
	with(global.oBoss)
	{
		//alarm[3] = FRAME_RATE * 0.25; //Return Boss to Idle state
		BossReturnToIdle();
	}
	instance_destroy(pobj_boss_crystal);
	SaveGame();
	x -= ultimate_skills[ultimate_skill_id][ULT_SKILL.OFFSET] * image_xscale;
	PlayerDeactivateUltimate();
	PlayerHeal(2,global.boss_manager.boss_current_enum);
}