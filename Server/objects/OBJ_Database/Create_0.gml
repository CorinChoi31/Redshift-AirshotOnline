#region
global.__frame = 60;
game_set_speed(global.__frame, gamespeed_fps);

global.__tick = 1;
global.__time = global.__tick/global.__frame;

global.tick = 0;
global.time = 0;
#endregion

var _i = 0;
#region
_i = 0;

global.__passive = [];
global.__passive[_i] = new InformationPassive("-", "기술을 선택하지 않았습니다.", -1); _i += 1;
global.__passive[_i] = new InformationPassive(
    "구조 증강: 재생성 생체 강철", 
    "손 복구 체력이 20% 더 늦게 감소하고 200% 빨리 수리됩니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "구조 증강: 충격 복원 합금", 
    "치명적인 피해를 받으면 그 피해를 무시하고 2초간 피해를 받지 않으며 그 동안 최대 내구도의 30% 를 수리합니다. 1회만 사용 가능하지만, 적을 처치하면 다시 충전됩니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "구조 증강: 탄성 흡수 강체", 
    "4초 동안 피해를 받지 않으면 다음 1회의 피해를 무시합니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "탄약 증강: 감지", 
    "발사한 탄약이 처음으로 벽에 부딫히면 가장 가까운 적을 향합니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "탄약 증강: 폭발", 
    "발사한 탄약이 적중하거나 만료되면 폭발하여 좁은 범위의 모든 기체에 기존 피해량의 50%의 피해를 입힙니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "탄약 증강: 손상", 
    "발사한 탄약이 적중하면 대상이 받는 피해가 10% 상승합니다. 효과는 1초 동안 유지되며 중첩에 제한이 없습니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "개조: 비결정질 합금", 
    "기본 탄약의 피해량이 30% 상승하지만, 기체 최대 내구도가 50% 감소합니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "개조: 소재 경량화", 
    "기체의 최대 속력과 가속력이 50% 상승하지만, 기본 탄약의 피해량이 20% 감소합니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "개조: 대포", 
    "기체 내구도가 40%, 기본 탄약의 피해량이 20% 증가하지만 기체 최대 속력이 10%, 무기 공격 속도가 20% 감소합니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "장착: 추격탄", 
    "기본 탄약을 4회 적중시키면, 가장 마지막으로 공격한 적에게 특수 탄환을 10회 발사합니다. 특수 탄환은 적중 시 기본 탄알 피해량의 5%의 피해를 입히고, 적의 최대 속력과 가속력을 8% 감소시킵니다.", 
    -1
); _i += 1;
global.__passive[_i] = new InformationPassive(
    "장착: 제어 미사일", 
    "기본 탄약을 7회 적중시키면, 기체의 진행 방향으로 미사일을 2회 발사합니다. 미사일은 폭발 시 기본 탄알 피해량의 70%의 피해를 입히고, 0.5초간 기술의 발동과 충전을 중단 시킵니다. 또한 근처의 적을 자동으로 적을 추적하며 기본 탄알 속력의 150% 로 추진합니다.", 
    -1
); _i += 1;
#endregion

#region
_i = 0;

global.__active = [];
global.__active[_i] = new InformationActive("-", "기술을 선택하지 않았습니다.", -1, 0); _i += 1;
global.__active[_i] = new InformationActive(
    "정지장", 
    "1초 동안, 주위 모든 투사체의 속력을 급격하게 감소시킵니다. 범위는 기체의 탄약 지속시간과 속력에 비례합니다.", 
    -1, 
    1
); _i += 1;
#endregion

#region
_i = 0;

global.__projectile = [];
global.__projectile[_i] = OBJ_Bullet; _i += 1;
global.__projectile[_i] = OBJ_Missile; _i += 1;
#endregion

#region
_i = 0;

global.__plane = [];
global.__plane[_i] = new InformationPlane(
    "Patrol_24",
    "중화력 중거리 기동함선",
    "",
    1,
    new Plane(
        new PlaneFrame(180, 2, 3),
        new PlaneEngine(4.5, 6, 0.175, 360),
        new PlaneWeapon(0.3, 1, 1, 0, 0, 1,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(GAME_DAMAGE.PHYSICAL, 8), 
                new PlaneWeaponProjectileForce(3, 25, 25, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(10, 
                new PlaneWeaponMagazineReload(-1, 1.5)
            )
        )
    )
); _i += 1;

global.__plane[_i] = new InformationPlane(
    "PAPER",
    "중화력 장거리 구축함선",
    "",
    2,
    new Plane(
        new PlaneFrame(140, 1, 2),
        new PlaneEngine(4, 4.5, 0.1, 270),
        new PlaneWeapon(0.4, 1, 1, 0, 0, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(GAME_DAMAGE.PHYSICAL, 12), 
                new PlaneWeaponProjectileForce(5, 35, 35, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(8, 
                new PlaneWeaponMagazineReload(-1, 2)
            )
        )
    )
); _i += 1;

global.__plane[_i] = new InformationPlane(
    "Marker",
    "저화력 장거리 기동함선",
    "",
    3,
    new Plane(
        new PlaneFrame(160, 1, 4),
        new PlaneEngine(8, 8, 0.2, 360),
        new PlaneWeapon(0.2, 2, 1, 0, 6, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(GAME_DAMAGE.PHYSICAL, 5), 
                new PlaneWeaponProjectileForce(3, 30, 30, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(6, 
                new PlaneWeaponMagazineReload(-1, 0.5)
            )
        )
    )
); _i += 1;

global.__plane[_i] = new InformationPlane(
    "==Patriot==",
    "고화력 장거리 구축함선",
    "",
    4,
    new Plane(
        new PlaneFrame(120, 1, 1),
        new PlaneEngine(4, 4, 0.125, 180),
        new PlaneWeapon(0.75, 1, 1, 0, 0, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(GAME_DAMAGE.PHYSICAL, 30), 
                new PlaneWeaponProjectileForce(4, 40, 40, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(4, 
                new PlaneWeaponMagazineReload(-1, 2)
            )
        )
    )
); _i += 1;

global.__plane[_i] = new InformationPlane(
    "BEARRER",
    "고화력 근거리 순항함선",
    "",
    5,
    new Plane(
        new PlaneFrame(200, 3, 6),
        new PlaneEngine(4.5, 1.5, 0.1, 240),
        new PlaneWeapon(0.8, 4, 2, 0.15, 4, 15,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 8, 8,
                new PlaneWeaponProjectileOnhit(GAME_DAMAGE.PHYSICAL, 6), 
                new PlaneWeaponProjectileForce(0.75, 25, 25, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(12, 
                new PlaneWeaponMagazineReload(4, 0.7)
            )
        )
    )
); _i += 1;

global.__plane[_i] = new InformationPlane(
    "Observer#1",
    "저화력 근거리 정찰선",
    "",
    6,
    new Plane(
        new PlaneFrame(150, 2, 8),
        new PlaneEngine(6, 6, 0.2, 480),
        new PlaneWeapon(0.1, 3, 1, 0, 12, 0,
            new PlaneWeaponProjectile(GAME_PROJECTILE.BULLET, 4, 4,
                new PlaneWeaponProjectileOnhit(GAME_DAMAGE.PHYSICAL, 2), 
                new PlaneWeaponProjectileForce(1, 35, 35, 0, 0, 0), 
                undefined
            ),
            new PlaneWeaponMagazine(15, 
                new PlaneWeaponMagazineReload(-1, 0.8)
            )
        )
    )
); _i += 1;
#endregion