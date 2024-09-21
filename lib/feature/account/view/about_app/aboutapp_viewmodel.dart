import 'package:caffely/feature/account/view/about_app/aboutapp_view.dart';
import 'package:caffely/product/core/base/base_state/base_state.dart';
import 'package:caffely/product/core/exception/service_exception/service_exceptions.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AboutAppViewModel extends BaseState<AboutAppView> {
  late String title = 'Caffely Uygulaması Hakkında';
  late String explanation = 'Caffely projesi, Nuhcan ATAR tarafından geliştirildi ve benim için bir öğrenme, keşfetme ve mobil uygulama geliştirme alanında kendimi daha da geliştirme fırsatı oldu. Bu projeyi geliştirirken, kısıtlı zamanımı en verimli şekilde kullanarak uygulamaya odaklandım. Caffely, tamamen ticari bir çıkar gözetmeden, kişisel gelişimimi ve toplulukla bilgi paylaşımını hedefleyen bir proje olarak ortaya çıktı. Proje sürecinde öğrendiklerimi hayata geçirmenin yanı sıra, mobil uygulama geliştirme topluluğuyla bilgi paylaşımının gücüne inanarak, projeyi GitHub üzerinde açık kaynak olarak paylaşıma sundum.\nGitHub üzerindeki Nuhcan ATAR hesabımda bulabileceğiniz bu projeye, mobil uygulama geliştirme dünyasına katkı sağlamak isteyen herkes ulaşabilir. Eğer siz de bir mobil geliştiriciyseniz, projenin açık kaynak kodlarını inceleyebilir, katkıda bulunabilir veya öneri ve görüşlerinizi paylaşabilirsiniz. Bu geri bildirimler hem proje hem de kişisel gelişimim açısından çok değerli. Amacım, ne kadar çok insanın mobil geliştirme dünyasında fayda sağlayabileceği projeler üretip, bu alana katkıda bulunabilirsem, o kadar anlamlı bir sonuç elde etmek.\nSonuç olarak, Caffely sadece bir uygulama değil; aynı zamanda mobil geliştiriciler için bir bilgi paylaşım aracı, kişisel gelişim için bir fırsat ve yaratıcı projeler geliştirme sürecimin bir yansımasıdır. Herkesin katkısına açık olan bu projeyi GitHub üzerinden inceleyebilir, dilediğiniz gibi geliştirebilir ve mobil uygulama geliştirme alanındaki bilgi birikimimizi genişletme yolculuğumda bana katılabilirsiniz!\n';

  late String githubUrl = 'https://github.com/NuhcanATAR';
  late String linkedinUrl =
      'https://www.linkedin.com/in/nuhcan-atar-371276208/';

  Future<void> linkOpen(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw ServiceException('Could not launch url: $url');
    }
  }
}
