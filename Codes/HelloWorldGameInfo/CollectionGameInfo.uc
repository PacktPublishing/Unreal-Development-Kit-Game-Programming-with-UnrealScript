//Collection Game Class

class CollectionGameInfo extends UTGame;

event Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);
	
	Broadcast(self, "Hello world!");
}

DefaultProperties
{
};