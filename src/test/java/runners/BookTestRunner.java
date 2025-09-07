package runners;

import com.intuit.karate.junit5.Karate;

public class BookTestRunner {

    @Karate.Test
    public Karate runBookTestRunner() {
        return  Karate.run("classpath:br/com/vale/features/bookStore/book.feature");
    }
}
