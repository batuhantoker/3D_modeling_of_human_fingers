import matplotlib.pyplot as plt
import numpy as np
from ttkSimpleDialog import ttkSimpleDialog
import tkinter as tk
import tkinter.ttk as ttk
import numpy as np
import matplotlib.animation as animation
def get_angles():

    root = tk.Tk()
    root.withdraw()

    # Loop through angles
    Angle1_start, Angle1_end = 0, 0
    Angle2_start, Angle2_end = 0, 0
    Angle3_start, Angle3_end = 0, 0
    Angle_npoints = 0
    for i in range(1, 4):
        prompt = f"Enter start value for Angle {i}:"
        title = f"Input for Angle {i}"
        dims = (1, 35)
        initialvalue = "0"
        angle_start = ttkSimpleDialog.askinteger(title, prompt, parent=root, initialvalue=initialvalue)
        angle_start = str(angle_start)
        prompt = f"Enter end value for Angle {i}:"
        title = f"Input for Angle {i}"
        dims = (1, 35)
        initialvalue = "20"
        angle_end = ttkSimpleDialog.askinteger(title, prompt, parent=root, initialvalue=initialvalue)
        angle_end = str(angle_end)
        if i == 1:
            Angle1_start, Angle1_end = angle_start, angle_end
        elif i == 2:
            Angle2_start, Angle2_end = angle_start, angle_end
        elif i == 3:
            Angle3_start, Angle3_end = angle_start, angle_end

    # Get number of points
    prompt = "Enter number of points for all angles:"
    title = "Input for number of points"
    dims = (1, 35)
    initialvalue = "200"
    angle_npoints = ttkSimpleDialog.askinteger(title, prompt, parent=root, initialvalue=initialvalue)
    Angle_npoints = angle_npoints

    # Generate angle arrays
    Angle1 = np.linspace(float(Angle1_start), float(Angle1_end), Angle_npoints)
    Angle2 = np.linspace(float(Angle2_start), float(Angle2_end), Angle_npoints)
    Angle3 = np.linspace(float(Angle3_start), float(Angle3_end), Angle_npoints)
    return Angle1, Angle2, Angle3, Angle_npoints

def plot_animation(Angle1, Angle2, Angle3, Angle_npoints):
    # Define constants
    l_pp = 45
    l_dp = 25
    l_ip = 30

    # Preallocate memory for the line data
    x1_data = np.zeros(Angle_npoints)
    y1_data = np.zeros(Angle_npoints)
    x2_data = np.zeros(Angle_npoints)
    y2_data = np.zeros(Angle_npoints)
    xe_data = np.zeros(Angle_npoints)
    ye_data = np.zeros(Angle_npoints)

    # Calculate line data in a vectorized manner
    x1_data = l_pp * np.cos(np.deg2rad(Angle1))
    y1_data = l_pp * np.sin(np.deg2rad(Angle1))
    x2_data = x1_data + l_ip * np.cos(np.deg2rad(Angle1 - Angle2))
    y2_data = y1_data + l_ip * np.sin(np.deg2rad(Angle1 - Angle2))
    xe_data = x2_data + l_dp * np.cos(np.deg2rad(Angle1 - Angle2 - Angle3))
    ye_data = y2_data + l_dp * np.sin(np.deg2rad(Angle1 - Angle2 - Angle3))

    plt.ion()

    # Set up plot
    fig, ax = plt.subplots()


    ax.set_xlabel('x axis')
    ax.set_ylabel('y axis')
    ax.set_xlim(-100, 100)
    ax.set_ylim(-100, 100)
    ax.set_xticks([-100, 50, 100])
    ax.set_yticks([-100, 50, 100])
    ax.grid()

    # Plot line data
    r_line, = ax.plot([0, x1_data[0]], [0, y1_data[0]], color='r', linewidth=2)
    b_line, = ax.plot([x1_data[0], x2_data[0]], [y1_data[0], y2_data[0]], color='b', linewidth=2)
    g_line, = ax.plot([x2_data[0], xe_data[0]], [y2_data[0], ye_data[0]], color='g', linewidth=2)


    # Plot line data
    r_line, = ax.plot([0, x1_data[0]], [0, y1_data[0]], color='r', linewidth=2)
    b_line, = ax.plot([x1_data[0], x2_data[0]], [y1_data[0], y2_data[0]], color='b', linewidth=2)
    g_line, = ax.plot([x2_data[0], xe_data[0]], [y2_data[0], ye_data[0]], color='g', linewidth=2)
    # Set labels for lines
    r_line.set_label('MCP')
    b_line.set_label('PIP')
    g_line.set_label('DP')

    # Add legend to the figure
    plt.legend(loc='upper left')
    # Add text annotation to the plot
    plt.annotate('Initial position', xy=(x1_data[0], y1_data[0]), xytext=(-50, -50), textcoords='offset points', fontsize=12, color='k', ha='left', va='bottom', arrowprops=dict(arrowstyle='->'))
    # Function to update plot data at each frame
    def update(num):
        r_line.set_xdata([0, x1_data[num]])
        r_line.set_ydata([0, y1_data[num]])
        b_line.set_xdata([x1_data[num], x2_data[num]])
        b_line.set_ydata([y1_data[num], y2_data[num]])
        g_line.set_xdata([x2_data[num], xe_data[num]])
        g_line.set_ydata([y2_data[num], ye_data[num]])

        return r_line, b_line, g_line

    # Display figure on the screen
    plt.show()

    # Create animation object
    ani = animation.FuncAnimation(fig, update, frames=range(Angle_npoints), interval=50, blit=False)

    # Save animation as GIF file
    ani.save('index_animation.gif', writer='imagemagick', fps=30)


# Call get_angles in a main loop
x=1
while x==1:
    Angle1, Angle2, Angle3 ,Angle_npoints = get_angles()

    plot_animation(Angle1, Angle2, Angle3 ,Angle_npoints)
    x=0




