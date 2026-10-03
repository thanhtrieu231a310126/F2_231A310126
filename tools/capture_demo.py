import subprocess,time
from pathlib import Path
adb='/Users/shini/Library/Android/sdk/platform-tools/adb'
out=Path('evidence')
def run(*a):return subprocess.run([adb,*a],check=True,stdout=subprocess.PIPE).stdout
def shot(n): (out/n).write_bytes(run('exec-out','screencap','-p'))
rec=subprocess.Popen([adb,'shell','screenrecord','--time-limit','70','/sdcard/f2_demo.mp4'])
time.sleep(2)
run('shell','input','tap','230','960');run('shell','input','text','231A310126');time.sleep(1)
run('shell','input','keyevent','4');time.sleep(1)
run('shell','input','tap','400','1145');time.sleep(1);run('shell','input','text','demo123');time.sleep(1);run('shell','input','keyevent','4');time.sleep(1);shot('keyboard_closed.png');run('shell','input','tap','965','1145');time.sleep(1)
run('shell','input','tap','965','1145');run('shell','input','tap','115','1280')
run('shell','input','tap','550','1550');time.sleep(.6);shot('snackbar.png');time.sleep(2)
run('shell','input','swipe','500','2070','500','850','700');time.sleep(1);shot('profile.png')
run('shell','input','swipe','500','550','500','2050','700');time.sleep(1)
run('shell','input','tap','993','220');time.sleep(1);shot('dark.png')
run('shell','input','tap','993','220');time.sleep(1)
run('shell','settings','put','system','accelerometer_rotation','0')
run('shell','settings','put','system','user_rotation','1');time.sleep(3);shot('landscape.png')
run('shell','input','swipe','1100','850','1100','400','600');time.sleep(2);shot('landscape_bottom.png')
run('shell','settings','put','system','user_rotation','0');time.sleep(2)
run('shell','pkill','-2','screenrecord');rec.wait(timeout=10)
run('pull','/sdcard/f2_demo.mp4','submission/F2_231A310126_demo.mp4')
