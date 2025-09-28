# ****************************************************************************************
#
#   raylib [core] example - Basic window
#
#   Welcome to raylib!
#
#   To test examples, just press F6 and execute raylib_compile_execute script
#   Note that compiled executable is placed in the same folder as .c file
#
#   You can find all basic examples on C:\raylib\raylib\examples folder or
#   raylib official webpage: www.raylib.com
#
#   Enjoy using raylib. :)
#
#   Example originally created with raylib 1.0, last time updated with raylib 1.0
#
#   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
#   BSD-like license that allows static linking with closed source software
#
#   Copyright (c) 2013-2023 Ramon Santamaria (@raysan5)
#   Converted to Nim by Antonis Geralis (@planetis-m) in 2022
#
# ****************************************************************************************

import raylib, raymath
#import rmem, reasings
import rcamera
import std/os
import std/options
import sugar
# ----------------------------------------------------------------------------------------
# Global Variables Definition
# ----------------------------------------------------------------------------------------

const
  screenWidth = 800
  screenHeight = 450

# ----------------------------------------------------------------------------------------
# Module functions Definition
# ----------------------------------------------------------------------------------------

proc testShowCursor() =
  showCursor()

proc testDrawRectangle() =
  let rec = Rectangle(x: 100, y: 100, width: 200, height: 150)
  let color = Red
  drawRectangle(rec, color)

proc testLoadImage(assetsFolder: string) : Option[Texture] =
  try:
    var image = loadImage(assetsFolder / "naylib.png")
    image.imageResize(128, 128)
    return some(image.loadTextureFromImage())
  except RaylibError:
    echo "Error loading image"
  return none(Texture)

proc testDrawText() =
  drawText("Hello, World!", 100, 100, 20, Black)

proc testDrawTextWithFont() =
  let font = getFontDefault()
  let position = Vector2(x: 200, y: 200)
  drawText(font, "Hello with custom font", position, 24, 2, DarkGray)

# ----------------------------------------------------------------------------------------
# Program main entry point
# ----------------------------------------------------------------------------------------

proc main =
  # Initialization
  # --------------------------------------------------------------------------------------
  initWindow(screenWidth, screenHeight, "raylib [core] example - basic window")
  setTargetFPS(60) # Set our game to run at 60 frames-per-second
  # --------------------------------------------------------------------------------------

  # Run tests
  var assetsPath = "assets/"

  # first arg is the assets folder .e.g. "assets/"
  if paramCount() >= 1:
    assetsPath = paramStr(1)

  testShowCursor()
  testDrawRectangle()
  let logo = testLoadImage(assetsPath)
  testDrawText()
  testDrawTextWithFont()

  # Main game loop
  while not windowShouldClose(): # Detect window close button or ESC key
    # Update
    # ------------------------------------------------------------------------------------
    # TODO: Update your variables here
    # ------------------------------------------------------------------------------------
    # Draw
    # ------------------------------------------------------------------------------------
    beginDrawing()
    clearBackground(RayWhite)
    drawFPS(5, 5)
    drawText("Congrats! You created your first window!", 190, 200, 20, DarkGray)
    # removing the type annotation below makes it a closure, not a nimcall, which is not accepted by nim compiler
    logo.map((t: Texture) => drawTexture(t, 660, 310, White))
    endDrawing()
    # ------------------------------------------------------------------------------------
  # De-Initialization
  # --------------------------------------------------------------------------------------
  closeWindow() # Close window and OpenGL context
  # --------------------------------------------------------------------------------------

main()
