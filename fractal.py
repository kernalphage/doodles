#!/bin/python
# Draws a 'fractal' tiling, inspired by /u/graaahh
# http://www.reddit.com/r/CasualMath/comments/230d5s/i_made_this_interesting_pattern_is_it_a_fractal/

import math
import turtle
import collections
State = collections.namedtuple("State", ["pos","heading"])
stateStack = []
maxDepth = 6
diagLen = 20;
horizLen = diagLen * math.sqrt(2) / 2.0; 

turtle.speed(0)

def drawBranch(depth, turns):
    if depth > maxDepth:
        return ""

    #approximation of the "collision" step.
    #if we go left too often, we're bound to have hit something
    pd = int(depth/2 + 1)
    if pd > 1 and (len(turns) >= pd and (turns[-pd:] == "l"*pd or turns[-pd:] == "r"*pd)):
        return ""
    curTree="[lf"
    curTree+=drawBranch(depth+1,turns+"l")
    curTree+="][rf"
    curTree+=drawBranch(depth+1,turns+"r")
    curTree+="]"
    return curTree

#Keep track of where the turtle was for later
def pushState():
    state = State(turtle.pos(), turtle.heading())
    stateStack.append(state)
def popState():
    state=stateStack.pop()
    turtle.setpos(state.pos)
    turtle.seth(state.heading)
   
#For each character in the L-string, command the turtle.
#Not a true L-system, right now we can't change the string while parsing
# http://en.wikipedia.org/wiki/L-system
def consumeLSystem(lString):
    for k in lString:
        if k =="l":
            turtle.left(45)
        if k =="r":
            turtle.right(45)
        if k =="f":
            curLen = 0
            if turtle.heading() % 90 > 1:
                curLen = diagLen
            else:
                curLen = horizLen
            turtle.forward(curLen)
        if k =="[":
            pushState()
        if k =="]":
            popState()

#Draw four branches
myTree = "[f" + drawBranch(0,"") + "]rr"
myTree += myTree + myTree + myTree
print(myTree)
consumeLSystem(myTree)
turtle.done();