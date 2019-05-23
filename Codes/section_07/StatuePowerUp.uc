class StatuePowerUp extends Actor
placeable
ClassGroup(MyGame, StatuePowerUp);

var() const editconst DynamicLightEnvironmentComponent LightEnvironment;
var() const editconst StaticMeshComponent StatueMesh;
	
var() float RotationSpeed;
var() SoundCue CueSample;
var() string ActorName;

auto state DefaultState
{
	Begin:
	GotoState('Spinning');
}

state Spinning
{
	event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
	{
		if(Pawn(Other) != None && Pawn(Other).Controller.bIsPlayer)
		{
				GotoState('Deactivated');
				PlaySound(CueSample);
				CollectionGameInfo(WorldInfo.Game).StatueCollected();
		}
	}

	event Tick(float DeltaTime)
	{
		//Called on each frame
		local float deltaRotation;
		local Rotator newRotation;
					
		deltaRotation = RotationSpeed * DeltaTime * DegToUnrRot;
					
		newRotation = Rotation;
					
		newRotation.Yaw += deltaRotation;
					
		SetRotation( newRotation ); 
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
}