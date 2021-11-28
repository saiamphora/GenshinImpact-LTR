state("GenshinImpact")
{
	// 2 offsets seem to change every patch now
	int loadBit : "UserAssembly.dll", 0x0AD706E8, 0x0A0, 0x0420;
}

startup
{
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show(
            "This game uses Time without Loads (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Genshin Impact | LiveSplit",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
	vars.setStartTime = false;
}

init
{
	
}

start
{
    if(old.loadBit == 0 && current.loadBit == 1) //End of first loading screen
    {
		vars.setStartTime = true;
        return true;
    }
}

update
{
	
}

isLoading
{
	return current.loadBit == 0;
}

gameTime
{
    if(vars.setStartTime)
    {
        vars.setStartTime = false;
        return TimeSpan.FromSeconds(-34.15);
    }
}

exit
{
    timer.IsGameTimePaused = true;
}