import tkinter as tk
from PIL import ImageTk, Image

first = (0, 0)

def get_coords(event):
    global first
    if first == (0, 0):
        first = (event.x, event.y)
    else:
        print(f"[{first[0]}, {first[1]}, {event.x - first[0]}, {event.y - first[1]}]")
        exit(0)

root = tk.Tk()
img = ImageTk.PhotoImage(Image.open("debug.jpg"))
label = tk.Label(root, image=img)
label.pack()
label.bind("<Button-1>", get_coords)
root.mainloop()