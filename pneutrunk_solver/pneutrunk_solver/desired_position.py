import rclpy
from rclpy.node import Node
from geometry_msgs.msg import PoseStamped
from geometry_msgs.msg import Pose
from sensor_msgs.msg import Joy
from std_msgs.msg import Header
from math import modf
import time
import numpy as np
from pneutrunk_msgs.msg import PneutrunkJointState 

class DesiredPosition(Node):
    # ros2 run joy joy_node
    def __init__(self):
        super().__init__("desired_position")
        self.publisher_ = self.create_publisher(Pose, '/pneutrunk/desired_position/cmd',10)
        self.subscriber_ = self.create_subscription(PoseStamped, '/Robot_1/pose', self.optitrack_position, 10)
        #self.subscriber2_ = self.create_subscription(PneutrunkJointState, "/pneutrunk/joints/state", self.is_in_workspace, 10)
        self.timer_ = self.create_timer(0.01, self.position)
        self.get_logger().info("Desired position...")
        self.end_effector = np.zeros(3)
        self.end_effector[0] = 0
        self.end_effector[1] = 0
        self.end_effector[2] = -978

    def optitrack_position(self, msg_optitrack):
        self.end_effector[0] = (msg_optitrack.pose.position.x*1000)
        self.end_effector[1] = (msg_optitrack.pose.position.y*1000)
        self.end_effector[2] = (msg_optitrack.pose.position.z*1000)     

    def position(self):
        msg_object = Pose()
        msg_object.position.x = 300.0#-(self.end_effector[0]) + 700
        msg_object.position.y = 600.0#-(self.end_effector[1]) + 550
        msg_object.position.z = -530.0#-(self.end_effector[2])
        self.publisher_.publish(msg_object)

def main(args=None):
    rclpy.init(args=args)
    node = DesiredPosition()  
    rclpy.spin(node)
    rclpy.shutdown()

if __name__ == "__main__":
    main()