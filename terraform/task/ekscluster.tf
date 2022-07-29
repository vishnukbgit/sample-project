resource "aws_eks_cluster" "ekscluster" {
  name     = "cluster1"
  role_arn = aws_iam_role.eksrole.arn

  vpc_config {
    subnet_ids = [aws_subnet.private_subnet.id,aws_subnet.private_subnet2.id]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role.eksrole
   # aws_iam_role_policy_attachment.eksroleattach-AmazonEKSClusterPolicy,
    #aws_iam_role_policy_attachment.eksroleattachcontroller-AmazonEKSVPCResourceController
  ]
}

########################################################################
# worker node creation
########################################################################


resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.ekscluster.name
  node_group_name = "node-group1"
  node_role_arn   = aws_iam_role.noderule.arn
  subnet_ids      =  [aws_subnet.private_subnet.id,aws_subnet.private_subnet2.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role.noderule
  ]
}

