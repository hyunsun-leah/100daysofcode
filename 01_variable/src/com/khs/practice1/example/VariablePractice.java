package com.khs.practice1.example;

import java.util.Scanner;

public class VariablePractice {

	/**
	 * �̸� (String), ���� (char), ���� (int), Ű (double)�� ����ڿ��� �Է� �޾� ������ ���� ������ ��� ����ϼ���
	 */
	public void method1() {
		
		Scanner sc = new Scanner(System.in);
		
		System.out.print("�̸��� �Է��ϼ��� : ");
		String name = sc.nextLine();
		
		System.out.print("���̸� �Է��ϼ��� : ");
		int age = sc.nextInt();
		
		sc.nextLine();
		
		System.out.print("������ �Է��ϼ���(��/��) :");
		char gender = sc.nextLine().charAt(0);
		
		System.out.print("Ű�� �Է��ϼ���(cm) : ");
		double height = sc.nextDouble();
		
		System.out.println("Ű " + height + "�� " + age + "�� " + gender + "�� " + name + "�� �ݰ����ϴ�^^");
		

	}

}
