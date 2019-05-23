/*******************************************************************************
	MyTestActor

	Creation date: 20/04/2013 10:13
	Copyright (c) 2013, alan
	<!-- $Id: NewClass.uc,v 1.1 2004/03/29 10:39:26 elmuerte Exp $ -->
*******************************************************************************/

class MyTestActor extends Actor
	placeable
	ClassGroup(MyGame, TestActor);

	var() const editconst DynamicLightEnvironmentComponent LightEnvironment;
	var() const editconst StaticMeshComponent StatueMesh;
	
	//Speed in degrees per second
	var() float RotationSpeed;
	
	//Reference to sound to play
	var() SoundCue CueSample;

auto state DefaultState
{
	Begin:
	GotoState('Spinning');
}	

state Spinning
{
	event Tick(float DeltaTime)
	{
		//Called on each frame
		local float deltaRotation;
		local Rotator newRotation;
		
		deltaRotation = RotationSpeed * DegToUnrRot;
		
		newRotation = Rotation;
		
		newRotation.Yaw += deltaRotation * DeltaTime);
		
		SetRotation( newRotation ); 
	}
	
	event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
	{
		if(Pawn(Other) != None && Pawn(Other).Controller.bIsPlayer)
		{
			GotoState('Deactivated');
			PlaySound(CueSample);
			
			//Collected state
			DerivedGameInfo(WorldInfo.Game).StatueCollected();
		}
	}
}

state Deactivated
{
}

DefaultProperties
{
	begin Object class=DynamicLightEnvironmentComponent Name=MyLightEnvironment
		bEnabled=true
	end Object
	LightEnvironment = MyLightEnvironment
	Components.Add(MyLightEnvironment);
	
	begin Object class=StaticMeshComponent Name=BodyMesh
		LightEnvironment=MyLightEnvironment
		StaticMesh = StaticMesh'Castle_Assets.Meshes.SM_MonkStatue_01'
	end Object
	
	StatueMesh = BodyMesh
	Components.Add(BodyMesh)

	bCollideActors=true
	bBlockActors=false
	
	RotationSpeed = 10
}

