import falcon

class WebHookResource:
    def on_get(self, req, resp):
        """Handles GET requests"""
        quote = {
            'message': 'Im a Web Hook'
        }

        resp.media = quote

api = falcon.API()
api.add_route('/hook', WebHookResource())