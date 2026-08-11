import time

schedule = [
    ["8:50", "9:00"],
    ["9:00", "9:45"],
    ["9:55", "10:40"],
    ["11:00", "11:45"],
    ["11:55", "12:40"],
    ["13:20", "14:05"],
    ["14:15", "15:00"],
]
curtime = time.localtime()


def checksec(sec):
    if sec == 60:
        return 1
    else:
        return 0


def sechelper(x):
    if x == 60:
        return 0
    else:
        return x


def sechelptwo(x):
    if x == 60:
        return 0
    else:
        return 1


def tmz(x, s):
    if x > 0:
        return str(x) + s + " "
    else:
        return ""


for x in schedule:
    Lessonstart = (int(x[0].split(":")[0]) * 60) + int(x[0].split(":")[1])
    Lessonend = (int(x[1].split(":")[0]) * 60) + int(x[1].split(":")[1])
    Curtime = (curtime.tm_hour * 60) + curtime.tm_min + checksec(curtime.tm_sec)
    if Lessonstart <= Curtime and Curtime < Lessonend:
        print(
            str(tmz(Lessonend - Curtime - sechelptwo(60 - curtime.tm_sec), "m"))
            + f"{tmz(sechelper(60-curtime.tm_sec), 's')}left"
        )
        exit(1)
print("No lesson.")
