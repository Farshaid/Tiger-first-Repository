package tiger.api.test.data;


import java.util.Date;

import com.github.javafaker.Faker;
import com.ibm.icu.text.SimpleDateFormat;

public class DataGenerator {
	
	Faker faker = new Faker();
					//------------------------ PRIMARY ACCOUNT ------------------------\\
	
	public static String getEmail() {
		Faker faker = new Faker();
		return faker.name().firstName() + faker.name().lastName() + "@gmail.com";
	}

	public static String getPhoneNumber() {
		Faker faker = new Faker();
		return faker.phoneNumber().cellPhone();
	}
	
	public static String getFirstName() {
		Faker faker = new Faker();
		return faker.name().firstName();
	}

	public static String getLastName() {
		Faker faker = new Faker();
		return faker.name().lastName();
	}
	
	public static String getDoB() {
		Faker faker = new Faker();
		Date date = faker.date().birthday();
		SimpleDateFormat format = new SimpleDateFormat("yyy-mm-dd");
		return format.format(date);
	}
	
	public static String getJob() {
		Faker faker = new Faker();
		return faker.job().title();
	}
	
					//------------------------ ADDRESS ------------------------\\
	
	public static String getCountry() {
		Faker faker = new Faker();
		return faker.address().country();
	}
	public static String getCity() {
		Faker faker = new Faker();
		return faker.address().city();
	}
	public static String getState() {
		Faker faker = new Faker();
		return faker.address().state();
	}
	public static String getZipCode() {
		Faker faker = new Faker();
		return faker.address().zipCode();
	}
	public static String getStreetAdd() {
		Faker faker = new Faker();
		return faker.address().streetAddress();
	}
	public static String getCountryCode() {
		Faker faker = new Faker();
		return faker.address().countryCode();
	}
					//-------------------------- Mobile Number ------------------------\\
	
	




}
