import com.devskiller.friendly_id.Url62
import java.util.UUID

fun main(args: Array<String>) {
  if (args.size != 2) {
    println("usage: <encode|decode> <value>")
    System.exit(1)
  }

  when (args[0]) {
    "encode" -> {
      val uuid = UUID.fromString(args[1])
      println(Url62.encode(uuid))
    }
    "decode" -> println(Url62.decode(args[1]))
    else -> println("Invalid command provided: '${args[0]}'")
  }
}

