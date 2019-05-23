//Collection Game Class

class CollectionGameInfo extends UTGame;

var int StatueCounter;
var int StatueLimit;
var bool GameWon;

function activateEventOutput(int Index)
{
	local Sequence Kismet;
	local array<SequenceObject> Results;
	local int i;
	local array<int> Indices;

	Kismet = WorldInfo.GetGameSequence();

	Kismet.FindSeqObjectsByClass(class'CollectedEvent', true, Results);

	for(i=0; i<Results.Length;i++)
	{
		Indices[0]=Index;
		CollectedEvent(Results[i]).CheckActivate(WorldInfo,none,false,Indices);
	}
}

exec function StatueCollected()
{
	StatueCounter += 1;
	
	Broadcast(self, "Statues Collected: " @ StatueCounter);
	
	if(StatueCounter >= StatueLimit)
	{
		GameWon = true;
		activateEventOutput(0);
	}
}

DefaultProperties
{
	GameWon = false;
	StatueLimit = 10;
	StatueCounter = 0;
	bDelayedStart = false;
};