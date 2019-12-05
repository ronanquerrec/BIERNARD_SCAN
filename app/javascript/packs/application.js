import "bootstrap";
import { showVideo } from "../components/video"
import { dismissNotifListener } from "../components/dismiss_notif"
import { setVh } from "../components/set_vh"
import { autocomplete } from "../components/autocomplete"
import { addRequiredSignIn } from "../components/sign_in_modal"

showVideo();
dismissNotifListener();
setVh();
autocomplete();
addRequiredSignIn();
