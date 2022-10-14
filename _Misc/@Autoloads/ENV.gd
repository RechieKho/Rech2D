extends Node

"""Environment variable"""



const TWEEN_TRANSITION_TYPE = Tween.TRANS_QUAD # default transition type
const TWEEN_EASE_TYPE = Tween.EASE_IN_OUT # default ease type

# Collision Layer Bits
const CLB_ENV  = 0 # layer 1
const CLB_BORDER = 1 # layer 2
const CLB_INTERACTABLE = 2 # layer 3
const CLB_INTERACTOR = 3 # layer 4
const CLB_CAMERA_MARKER = 4 # layer 5
const CLB_PLAYER_HEALTH = 5 # layer 6
const CLB_ENEMY_HEALTH = 6 # layer 7
const CLB_ATTACK_BEAT_AREA = 9 # layer 10
const CLB_LIFT_BEAT_AREA = 10 # layer 11

# Screen Space Effect Stack Index
const GFXSI_CIRCLE_SIZE_GAME_ROOM = 0
const GFXSI_CIRCLE_SCATTER_INTENSITY_GAME_ROOM = 0
const GFXSI_CIRCLE_SIZE_PLAYER = 1
const GFXSI_CIRCLE_SCATTER_INTENSITY_PLAYER = 1
const GFXSI_BLUR_INTENSITY_GAME_ROOM = 0
const GFXSI_BLUR_SIZE_GAME_ROOM = 0
const GFXSI_BLUR_SCATTER_INTENSITY_GAME_ROOM = 0

# Music stack Index
const MSI_NORMAL = 0
const MSI_FIGHT = 1
