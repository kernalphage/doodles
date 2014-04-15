import math
import turtle
import collections
State = collections.namedtuple("State", ["pos","heading"])
stateStack = []
maxDepth = 6
diagLen = 20;
horizLen = diagLen * math.sqrt(2) / 2.0; 

turtle.speed(0)

def drawLeg(depth, turns):
    curTree = "";
    if depth > maxDepth:
        return ""
    curTree +=("[lf")
    if(turns > 0):
        if(turns <= depth/2.0 ):
            curTree +=drawLeg(depth+1, turns + 1)
    else:
        curTree += drawLeg(depth+1, 1)
    curTree +=("][rf")
    if(turns < 0):
        if(turns >= -1 * (depth/2.0 )):
            curTree +=drawLeg(depth+1,-1)
    else:
        curTree+=drawLeg(depth+1,-1)
    curTree +=("]")
    return curTree


def drawBranch(depth, turns):
    if depth > maxDepth:
        return ""
    
    pd = int(depth/2 + 1)

    if(len(turns) >= pd):
        print(turns, turns[-pd:])
    if pd > 1 and (len(turns) >= pd and (turns[-pd:] == "l"*pd or turns[-pd:] == "r"*pd)):
        return ""
    curTree =""
    curTree+="[lf"
    curTree+=drawBranch(depth+1,turns+"l")
    curTree+="][rf"
    curTree+=drawBranch(depth+1,turns+"r")
    curTree+="]"
    return curTree

#state machine
def pushState():
    state = State(turtle.pos(), turtle.heading())
    stateStack.append(state)
def popState():
    state=stateStack.pop()
    turtle.setpos(state.pos)
    turtle.seth(state.heading)
    
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
            
myTree = "[f" + drawBranch(0,"") + "]rr"
myTree += myTree + myTree + myTree
print(myTree)
consumeLSystem(myTree)
turtle.done();
