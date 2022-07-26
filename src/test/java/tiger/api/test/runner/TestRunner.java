package tiger.api.test.runner;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
	@Karate.Test
	public Karate runTest() {
		return Karate.run("classpath:Features")
				.tags("Regression");
	}
}

//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