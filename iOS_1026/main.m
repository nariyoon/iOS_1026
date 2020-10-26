#import <Foundation/Foundation.h>

#if 0
class Car {
  int color;
public:
  Car(): color(0) {}                  // 기본 생성자
  Car(int n): color(n) {}
};
#endif

// 초기화 메소드
//   => "생성자" 개념과 동일합니다.

// 1. ObjC에서는 필드의 이름규칙
//      _color, _age, _speed

@interface Car : NSObject {
  int _color;
}

- (id)init;

// ObjC는 아래처럼 id를 반환하고, init으로 시작하는 메소드를 초기화 메소드로 취급합니다.
- (id)initWithColor:(int)color;


- (int)color;
// ObjC에서는 getter를 만들때 필드의 _를 제거한 이름을 사용하는 것이 원칙입니다.

@end

@implementation Car

- (int)color {
  return _color;
}

// 2. ObjC에서 초기화 메소드를 만드는 방법
//  - 초기화 메소드에서는 self의 값을 변경하는 것이 가능합니다.

// void*: 모든 타입의 포인터(참조)를 담을 수 있는 타입
//    id: 모든 객체 타입의 포인터를 담을 수 있는 타입

// NULL:  #define NULL (void*)0
//  nil:  #define nil  (id)0

- (id)init {
  printf("init\n");
  // 1. 부모의 초기화 메소드를 명시적으로 호출합니다.
  //    초기화 메소드가 실패할 경우, nil을 반환합니다.
  self = [super init];
  
  // 2. 부모의 초기화메소드가 실패하지 않을 경우, 자신의 필드를 초기화합니다.
  if (self != nil) {  // if (self) {
    _color = 42;
  }
  
  // 3. self를 반환합니다.
  return self;
}

- (id)initWithColor:(int)color {
  printf("initWithColor\n");
  self = [super init];
  if (self) {
    _color = color;
  }
  return self;
}


@end

// new: 무조건 init을 호출합니다.
//  1. 메모리를 할당합니다.                   -  Car* obj = [Car alloc];
//  2. 할당된 메모리를 대상으로 init을 호출합니다. - [obj init];

// init이 아닌 사용자가 정의한 초기화 메소드를 사용하기 위해서는
// 객체의 메모리 할당과 초기화 메소드를 직접 호출해야 한다.
//  => 2단계 생성 패턴

int main() {
  // Car* car = [Car new];
  
  // Car* car = [Car alloc];
  // car = [car initWithColor:100];
  
  Car* car = [[Car alloc] initWithColor:100];
  printf("color: %d\n", [car color]);
}
