package com.khs.practice1.example;

import java.util.Scanner;

public class VariablePractice {

	/**
	 * 이름 (String), 성별 (char), 나이 (int), 키 (double)를 사용자에게 입력 받아 각각의 값을 변수에 담고 출력하세요
	 */
	public void method1() {
		
		Scanner sc = new Scanner(System.in);
		
		System.out.print("이름을 입력하세요 : ");
		String name = sc.nextLine();
		
		System.out.print("나이를 입력하세요 : ");
		int age = sc.nextInt();
		
		sc.nextLine();
		
		System.out.print("성별을 입력하세요(남/여) :");
		char gender = sc.nextLine().charAt(0);
		
		System.out.print("키를 입력하세요(cm) : ");
		double height = sc.nextDouble();
		
		System.out.println("키 " + height + "인 " + age + "살 " + gender + "자 " + name + "님 반갑습니다^^");
		

	}

}
