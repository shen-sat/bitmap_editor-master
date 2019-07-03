# Bitmap editor

..

# Running

`>bin/bitmap_editor examples/test_input.txt`

# Testing

`rspec`

# Assumptions

 - A plateau is divided into a grid
 - A bitmap starts at coordinates 1,1 (top-left corner)
 - Maximum bitmap coordinate is 250,250
 - Inputs are lines with numbers or letters separated by spaces
 - All letters are uppercase
 - Bitmaps can not be edited unless an 'I' (create bitmap) command is provided 

# Design

I've used Ruby for this app. I've used objects to represent the bitmap editor, input validator and processor. The objects and their structure were formed using test-driven development (TTD). The input validator ensures input adheres to the assumptions listen above. The processor checks if a bitmap exists, converts input to an array and then uses this array to edit the bitmap.

The app runs and returns the correct output for the supplied test input. 

