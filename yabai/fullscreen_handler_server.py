# So, this is my yabai fullscreen handler
# Its job is to: Take the yabai application open AND resize events, and upon their trigger, add the app id to a state
# On the user attempting to swap spaces, a state handler will run, which will: TAKE STATE DATA, and remove all items from that space over to a different space, delete the space, and move the new fullscreen space into place
from subprocess import run
from sys import argv


def get_state():
    with open("./fullscreen_state", "r") as f:
        return f.read()


def write_state(d):
    with open("./fullscreen_state", "r") as f:
        f.write(d)


def remove_space_id(id):
    run(["yabai", "-m", "space", String(id)])


# So, first, we need to handle data, my plan for this is for the system to alert me before something changes, so we can log state, and depending on the changes enacted, we can work from it


run(["yabai", "-m", "space", argv[1], "--swap", "2"])
run(["yabai", "-m", "space", argv[1], "--destroy"])
