module Steven
  module Responder
    extend Discordrb::EventContainer

    @responses = YAML.load_file("#{Dir.pwd}/data/responses.yml")

    reaction_add do |event|
      if event.emoji.name == "steven"
        event.respond "You rang?"
      end
    end

    message do |event|
      return unless event.message.emoji?

      emojis = event.message.emoji.compact
      return unless emojis

      if emojis.map(&:name).include?("steven")
        user = event.author

        response = @responses.sample.gsub("-mention-", user.mention)

        event.respond response
      end
    end
  end
end
