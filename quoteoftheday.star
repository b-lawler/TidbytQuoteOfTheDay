load("render.star", "render")
load("http.star", "http")

def main(config):
    Quote_Of_Day_URI = "https://zenquotes.io/api/random"
    response = http.get(Quote_Of_Day_URI)
    if response.status_code != 200:
        fail("Request failed with status %d", response.status_code)
    response = response.json()
    quote = response[0]["q"]
    author = response[0]["a"]

    quote_word_count = len(quote.split())

    return render.Root(
        delay = 60,
        child = render.Stack(
            children = [
                render.Box(
                    width = 64,
                    height = 32,
                    color = "#38280c"
                ),
                render.Marquee(
                    height = 32 + int((quote_word_count * 1.4)),
                    scroll_direction = "vertical",
                    offset_start = 33,
                    offset_end = 33,
                    child = render.Column(
                        cross_align = "center",
                        children = [
                            render.WrappedText(
                                content="Daily Quote", 
                                font="5x8", 
                                color="#dbdbdb"
                            ),
                            render.Padding(
                                render.WrappedText(
                                    content = quote,
                                    font="tb-8",
                                    color="#ad9d8b"
                                ),
                                pad = (0,9,0,1)
                            ),
                            render.WrappedText(
                                width = 64,
                                content = "-" + author,
                                font = "tom-thumb",
                                color = "#949494"
                            )
                        ]
                    )
                )
            ]
        )
    )