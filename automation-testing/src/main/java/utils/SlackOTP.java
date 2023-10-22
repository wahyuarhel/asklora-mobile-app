package utils;

import com.slack.api.Slack;
import com.slack.api.methods.MethodsClient;
import com.slack.api.methods.SlackApiException;
import com.slack.api.methods.response.conversations.ConversationsHistoryResponse;
import com.slack.api.model.Message;
import io.github.cdimascio.dotenv.Dotenv;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import static java.util.Collections.emptyList;

    /**
     * Source otpCode documentation found here: <a href="https://api.slack.com/messaging/retrieving">Link</a>
     */

public class SlackOTP {

    Optional<List<Message>> conversationHistory = Optional.empty();
    String msg;
    String otpCode;

    /**
     * Fetch conversation history and find message that contains the specific email in #get-your-otp-here-dev on slack
     * Only works on the Dev build
     */
    public String fetchHistory(String email) {
        final String directory = String.valueOf(new File(System.getProperty("user.dir")).getParent());
        Dotenv dotenv = Dotenv.configure().directory(directory).filename(".env").load();

        MethodsClient client = Slack.getInstance().methods();
        try {
            // Get conversation history of #got-your-otp-here-dev
            ConversationsHistoryResponse result = client.conversationsHistory(r -> r
                    .token(dotenv.get("SLACK_BOT_TOKEN"))
                    .channel("C02E89AQ8RF")
            );
            conversationHistory = Optional.ofNullable(result.getMessages());
            int conversationNum = conversationHistory.orElse(emptyList()).size();
            for (int i = 0; i < conversationNum; i++) {
                Message message = result.getMessages().get(i);
                if (message.getText().contains(email)) {
                    msg = message.getText();
                    otpCode = msg.substring(msg.length() - 6);
                    break;
                }
            }
        } catch (IOException | SlackApiException e) {
            e.printStackTrace();
        }
        return otpCode;
    }

//    public static void main(String[] args) {
//        System.out.println(fetchHistory("joe.biden@yopmail.com"));
//    }

}


//C02E89AQ8RF