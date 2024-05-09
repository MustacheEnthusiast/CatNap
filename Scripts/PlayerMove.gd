extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const DRAG = 2.0
const FORCE = 2.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var SpeepCurve : Curve
var speedlevel : float


var sens : float = 0.2
@onready
var Pivot = $CameraArm
@onready
var Ray = $Interact
@onready var label = $UI_Layer/UI/Interact
@onready var hold_space = $HoldingArm

var heldItem : Node3D

var canInteract : bool = false 

func _ready():
##Mouse Capture
	CamLock()


func _process(_delta):
	check_raycast()

func _physics_process(delta):
	
	Gravity(delta)
	
	
	PlayerMovement()
	

#region Raycast

func setCanInteract(check):
	if canInteract != check:
		if check:
			label.show()
		else:
			label.hide()
		canInteract = check
		showUI(check)

func showUI(_check):
	# set the UI to the check to indicate to the player if they can interact with something
	pass

func AddChild(child):
	child.get_parent().remove_child(child)
	hold_space.add_child(child)
	hold_space.add_excluded_object(child)
	heldItem = child
	child.global_position = hold_space.global_position 

func execute_child():
	if heldItem.has_method("IS_stop_touching_me"):
		heldItem.IS_stop_touching_me()
	var old_pos = heldItem.global_position
	hold_space.remove_child(heldItem)
	self.get_parent().add_child(heldItem)
	hold_space.remove_excluded_object(heldItem)
	heldItem.global_position = old_pos
	heldItem = null

func check_raycast():
	
	if heldItem != null:
		if Input.is_action_just_pressed("MouseClick"):
			execute_child()
	elif Ray.is_colliding():
		#print(Ray.get_collider())
		setCanInteract(Ray.get_collider().has_method("IS_on_interact"))
		if canInteract:
			label.text = "Interact with " + Ray.get_collider().name
			if Input.is_action_just_pressed("MouseClick"):
				Ray.get_collider().IS_on_interact(self)
	else:
		setCanInteract(false)

#endregion

#region Player Movement
func Gravity(delta):
			# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta



func PlayerMovement():
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:

		
		#translate_object_local(Vector3(input_dir.x, 0, input_dir.y) * SPEED * delta)
		##return
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		
		
		#velocity.lerp(Vector3(0,0,0), delta)
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

#endregion

#region Camera movement

func CamLock():
	hold_space.add_excluded_object(self)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
## Camera to mouse control
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens))
		Pivot.rotate_x(deg_to_rad(-event.relative.y * sens))
		Pivot.rotation.x = clamp(Pivot.rotation.x, deg_to_rad(-65), deg_to_rad(90))

func CameraCtrl():
	
	
	
	pass

#endregion







