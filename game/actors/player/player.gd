extends Node2D

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    animationPlayer.play('idle')