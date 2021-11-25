resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

 parameters = {
    VPCCidr = "10.0.0.0/16"
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
     "Web1" : {
	"Type": "AWS::EC2::Instance",
	"Properties" : {
	  "ImageId" : "ami-083654bd07b5da81d", 
	  "InstanceType" : "t2.micro", 
	  "SecurityGroups" : [
	     {"Ref" : "web_sg"}
	  ],
	  "Tags" : [
	    {"Key": "Name", "Value": "Primary_CF_EC2"}
	  ]
	  }
	}
       }
      }
    }
  }
}
STACK
}
