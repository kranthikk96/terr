resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

 parameters = {
    VPCCidr = "10.0.0.0/16"
    ImageId:
    Description: Image ID to launch EC2 instances.
    Type: AWS::EC2::Image::Id
    # amzn-ami-hvm-2016.09.1.20161221-x86_64-gp2
    Default: ami-9be6f38c
  InstanceType:
    Description: Instance type to launch EC2 instances.
    Type: String
    Default: m3.medium
    AllowedValues: [ m3.medium, m3.large, m3.xlarge, m3.2xlarge ]
  }

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
   "Resources" : {
		"Web1" : 
		{
			"Type":"AWS::EC2::Instance",
			"Properties":
			{
				"ImageId":"ami-08111162", 
				"InstanceType":"t2.micro", 
				"SecurityGroups":
				[
					{
						"Ref":"WebSecuirtyGroup"
					}
				], 
				"KeyName":"devopstest",
				"Tags": 
				[
					{
						"Key":"Dev",
						"Value":"Dev"
					}
				]
			}
		}     
      }
    }
  }
}
STACK
}
