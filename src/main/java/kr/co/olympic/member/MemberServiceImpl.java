package kr.co.olympic.member;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import kr.co.olympic.game.GameVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public int regist(MemberVO vo) {
		// 회원가입 실패하면 0 성공하면 1
		return mapper.regist(vo) == 0 ? 0 : 1;
	}

	@Override
	public int emailCheck(String email) {
		return mapper.emailCheck(email);
	}

	@Override
	public MemberVO login(MemberVO vo) {
		return mapper.login(vo);
	}

	@Override
	public int findPwd(MemberVO vo) {
		return mapper.findPwd(vo);
	}

	@Override
	public int pwdCheck(MemberVO vo) {
		return mapper.pwdCheck(vo) == 0 ? 0 : 1;
	}

	@Override
	public MemberVO detail(MemberVO vo) {
		return mapper.detail(vo);
	}

	@Override
	public int update(MemberVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(MemberVO vo) {
		return mapper.delete(vo);
	}

	@Override
	public int buy_membership(MemberVO vo) {
		return mapper.buy_membership(vo);
	}

	@Override
	public List<CouponVO> coupon_list(MemberVO vo) {
		return mapper.coupon_list(vo);
	}
	
	@Override
	public int insert_coupon(CouponVO vo) {
		return mapper.insert_coupon(vo);
	}

	@Override
	public MemberVO checkEmail(MemberVO vo) {
		return mapper.checkEmail(vo);
	}

	@Autowired
	JavaMailSender emailSender; // MailConfig에서 등록해둔 Bean을 autowired하여 사용하기
	private String ePw; // 사용자가 메일로 받을 인증번호

	@Override
	public MimeMessage creatMessage(String to) throws MessagingException, UnsupportedEncodingException {
		System.out.println("메일받을 사용자" + to);
		System.out.println("인증번호" + ePw);

		MimeMessage message = emailSender.createMimeMessage();

		message.addRecipients(RecipientType.TO, to); // 메일 받을 사용자
		message.setSubject("[olympic] 회원가입을 위한 이메일 인증코드 입니다"); // 이메일 제목

		String msgg = "";
		msgg += "<div style='font-family: Arial, sans-serif; margin: 0; padding: 0; text-align: center; border: 1px solid black;'>";
		msgg += "<div class='header' style='margin-top:3%;'>";
		msgg += "<img src='https://olympics.com/images/static/b2p-images/logo_color.svg' alt='오륜기' style='width:100%; max-width:600px; height:auto; margin-bottom:5%'>";
		msgg += "</div>";
		msgg += "<div class='content' style='padding: 20px;'>";
		msgg += "<h1>Olympic 사이트에 방문해 주셔서 감사합니다.</h1>";
		msgg += "<p>아래 인증코드를 회원가입 페이지에 입력해주세요</p>";
		msgg += "<div class='code-box'style='font-size: 130%; margin-top: 10px;'>";
		msgg += "<h3>회원가입 인증코드 입니다</h3>";
		msgg += "<div style='font-size:130%'>";
		msgg += "<div><strong style='color: red;'>" + ePw + "</strong></div>"; // 메일에 인증번호 ePw 넣기
		msgg += "</div>";
		msgg += "</div>";
		msgg += "<div class='footer' style='position: relative; overflow: hidden; height: 70vh; margin-top:5%;'>";
		msgg += "<img src='https://img.olympics.com/images/image/private/t_16-9_1920/f_auto/primary/fruxzacvbdyyunj6fczo' alt='올림픽' style='width:100%;  height:auto;  opacity: 0.7;'>";
		msgg += "</div>";
		msgg += "</div>";
		message.setText(msgg, "utf-8", "html"); // 메일 내용, charset타입, subtype
		// 보내는 사람의 이메일 주소, 보내는 사람 이름
		message.setFrom(new InternetAddress("shdsearlybird@naver.com", "Olympic_Admin"));

		// 출력 확인
		//System.out.println("********creatMessage 함수에서 생성된 msgg 메시지********" + msgg);
		//System.out.println("********creatMessage 함수에서 생성된 리턴 메시지********" + message);

		return message;
	}

	// 랜덤 인증코드 생성
	@Override
	public String createKey() {
		int leftLimit = 48; // numeral '0'
		int rightLimit = 122; // letter 'z'
		int targetStringLength = 10;
		Random random = new Random();
		String key = random.ints(leftLimit, rightLimit + 1).filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
				.limit(targetStringLength)
				.collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
		System.out.println("생성된 랜덤 인증코드" + key);
		return key;
	}
    // 메일 발송
    // sendSimpleMessage 의 매개변수 to는 이메일 주소가 되고,
    // MimeMessage 객체 안에 내가 전송할 메일의 내용을 담는다
    // bean으로 등록해둔 javaMail 객체를 사용하여 이메일을 발송한다
    @Override
    public String sendSimpleMessage(String to) throws Exception {

        ePw = createKey(); // 랜덤 인증코드 생성
        System.out.println("********생성된 랜덤 인증코드******** => " + ePw);

        MimeMessage message = creatMessage(to); // "to" 로 메일 발송

//        System.out.println("********생성된 메시지******** => " + message);

        try { // 예외처리
            emailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException();
        }

        return ePw; // 메일로 사용자에게 보낸 인증코드를 서버로 반환! 인증코드 일치여부를 확인하기 위함
    }

	@Override
	public List<GameVO> listFavorite(MemberVO vo) {
		return mapper.listFavorite(vo);
	}

}
