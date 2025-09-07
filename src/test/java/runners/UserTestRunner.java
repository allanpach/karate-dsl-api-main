package runners;

import com.intuit.karate.junit5.Karate;

public class UserTestRunner {

    @Karate.Test
    public Karate runUserTestRunner() {
        return  Karate.run("classpath:br/com/vale/features/account/users.feature");
    }
}
