# convert the input into a matrix

# light starts in the top left corner moving right moving one step each time

# if encountering . continue

# if encountering | and moving up continue
# if encountering | and moving down continue
# if encountering | and moving left next move is up and down (both happen)
# if encountering | and moving right next move is up and down (both happen)

# if encountering - and moving up next move is left and right (both happen)
# if encountering - and moving down next move is left and right (both happen)
# if encountering - and moving left continue
# if encountering - and moving right continue

# if encountering \ and moving up next move is left
# if encountering \ and moving down next move is right
# if encountering \ and moving left next move is up
# if encountering \ and moving right next move is down
 
# if encountering / and moving up next move is right
# if encountering / and moving down next move is left
# if encountering / and moving left next move is down
# if encountering / and moving right next move is up

# mark cell in adjacent matrix as energised if not already marked as energised
# when finished propagating light through the matrix, count the number of energised cells in the adjacent matrix