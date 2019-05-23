/*******************************************************************************
	DerivedGameInfo

	Creation date: 20/04/2013 10:07
	Copyright (c) 2013, alan
	<!-- $Id: NewClass.uc,v 1.1 2004/03/29 10:39:26 elmuerte Exp $ -->
*******************************************************************************/

class DerivedGameInfo extends UTGame;

var() int StatueCounter;

var bool GameWon;

var int StatueMax;

event PostLogin( PlayerController NewPlayer )
{
	//Super class does its thing!
	Super.PostLogin(NewPlayer);
	
	Broadcast(self, "Hello World");
}

exec function StatueCollected()
{
	//Increment counter
	StatueCounter += 1;
	
	//Check for win condition
	Broadcast(self, "Statues Collected: " @ StatueCounter);
	
	if(StatueCounter > StatueMax)
	{
		//Set Game Won
		GameWon = true;
	}
}

DefaultProperties
{
	StatueMax = 10;
	bDelayedStart=false;
	GameWon=false;
	StatueCounter = 0;
}
