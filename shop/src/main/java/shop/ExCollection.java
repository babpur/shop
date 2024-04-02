package shop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class ExCollection {

	public static void main(String[] args) {
		// API == 도구
		// 프레임워크 == 
		
		// 1. 배열
		String[] arr = new String[3];
		arr[0] = "루피"; // a) 배열에 데이터 할당 시 index를 알아야 한다. 
		arr[1] = "조로"; // b) index만 갖고 데이터 추측이 힘들다.
		arr[2] = "루피"; // c) 중복된 데이터값을 피할 수 없다.
		// arr[3] = "나미"; // d) index 범위를 초과할 수 없다.
		for(String s : arr) {
			System.out.println(s);
		}
		
		System.out.println("----------------------");
		
		// 2. 컬렉션 프레임워크(자바 기본 API 제공)
		// 1) 리스트
		ArrayList<String> list = new ArrayList<String>(2);
		list.add("루피"); // a)
		list.add("조로");
		list.add("나미"); // d) 동적 배열
		list.add("조로");
		
		for(String s : list) {
			System.out.println(s);
		}
		
		System.out.println("----------------------");
		
		
		HashSet<String> set = new HashSet<String>();
		set.add("루피"); // c)
		set.add("루피"); // 중복된 데이터를 허용하지 않음
		for(String s : set) {
			System.out.println(s);
		}
	
		// System.out.println(set.get((0)); // index 존재하지 않음
		
		System.out.println("----------------------");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("선장", "루피");
		map.put("부선장", "조로");
		map.put("항해사", "나미");
		System.out.println(map.get("부선장")); // b) index 대신 문자열도 가능
		
		
		System.out.println("----------------------");
		
		// 4) List + Map 같이 사용
		ArrayList<HashMap<String, String>> mapList
			= new ArrayList<HashMap<String, String>>(); 
		HashMap<String, String> m1 = new HashMap<String, String>();
		m1.put("name", "루피");
		m1.put("pirateName", "밀짚모자해적단");
		
		HashMap<String, String> m2 = new HashMap<String, String>();
		m2.put("name", "샹크스");
		m2.put("pirateName", "빨간머리해적단");
		
		mapList.add(m1);
		mapList.add(m2);
		
		for(HashMap m : mapList) {
			System.out.printf("%s, %s\n", m.get("name"), m.get("pirateName"));
		}
	}
}
