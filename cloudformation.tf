resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

  parameters:
    InstanceCount:
      Description: Number of EC2 instances (must be between 1 and 5)
      Type: Number
      Default: 1
      MinValue: 1
      MaxValue: 5
      ConstraintDescription: Must be a number between 1 and 5.
    ImageId:
      Description: Image ID to launch EC2 instances.
      Type: AWS::EC2::Image::Id
      # amzn-ami-hvm-2016.09.1.20161221-x86_64-gp2
      Default: ami-9be6f38c
    InstanceType:
      Description: Instance type to launch EC2 instances.
      Type: String
      Default: t2.micro
      AllowedValues: [ t2.micro,m3.medium, m3.large, m3.xlarge, m3.2xlarge ]
  Conditions:
    Launch1: !Equals [1, 1]
    Launch2: !Not [!Equals [1, !Ref InstanceCount]]
    Launch3: !And
    - !Not [!Equals [1, !Ref InstanceCount]]
    - !Not [!Equals [2, !Ref InstanceCount]]
    Launch4: !Or
    - !Equals [4, !Ref InstanceCount]
    - !Equals [5, !Ref InstanceCount]
    Launch5: !Equals [5, !Ref InstanceCount]
  Resources:
    Instance1:
      Condition: Launch1
      Type: AWS::EC2::Instance
      Properties:
        ImageId: !Ref ImageId
        InstanceType: !Ref InstanceType
   Instance2:
     Condition: Launch2
     Type: AWS::EC2::Instance
     Properties:
       ImageId: !Ref ImageId
       InstanceType: !Ref InstanceType
   Instance3:
     Condition: Launch3
     Type: AWS::EC2::Instance
     Properties:
       ImageId: !Ref ImageId
       InstanceType: !Ref InstanceType
   Instance4:
     Condition: Launch4
     Type: AWS::EC2::Instance
     Properties:
       ImageId: !Ref ImageId
       InstanceType: !Ref InstanceType
   Instance5:
     Condition: Launch5
     Type: AWS::EC2::Instance
     Properties:
       ImageId: !Ref ImageId
       InstanceType: !Ref InstanceType
  

  template_body = <<STACK
{
  "Parameters" : {
    "VPCCidr" : {
      "Type" : "String",
      "Default" : "10.0.0.0/16",
      "Description" : "Enter the CIDR block for the VPC. Default is 10.0.0.0/16."
    }
  },
  "Resources" : {
    "myVpc": {
      "Type" : "AWS::EC2::VPC",
      "Properties" : {
        "CidrBlock" : { "Ref" : "VPCCidr" },
        "Tags" : [
          {"Key": "Name", "Value": "Primary_CF_VPC"}
        ]
      }
    }
  }
}
STACK
}
